class JobSequence
  attr_accessor :input

  def self.calculate(input)
    js = self.new(input)
    js.result
  end 

  def initialize(input)
    self.input = input
  end

  def result
    sequence.join
  end
  

  def self_dependency_exists?
    jobs.any? do |job|
      job.dependency == job.name
    end
  end

  def circular_dependency_exists?
    jobs.any? do |job|
      (dependents(job) & depends_upon(job)).size > 0
    end
  end

  private
  def dependents(target, list = [])
    jobs.each do |job|
      next unless job.dependency == target.name
      list.push(job.name)
      list += dependents(job, list) unless list.include?(job.dependency)
    end

    list
  end

  def depends_upon(target, list = [])
    jobs.each do |job|
      next unless job.name == target.dependency
      list.push(job.name)
      list += depends_upon(job, list) unless list.include?(job.dependency)
    end

    list
  end

  def jobs    
    lines = self.input.split("\n")
    lines.collect do |line|
      Job.new(line)
    end
  end

  
  

  def sequence
    jobs.reduce([]) do |sequence, job|
      sequence.push(job.name) unless sequence.include?(job.name)

      if job.dependency
        sequence.delete(job.dependency)

        dependent_position = sequence.index(job.name)
        sequence.insert(dependent_position, job.dependency)
      end

      sequence
    end
  end
end