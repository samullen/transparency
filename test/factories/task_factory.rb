class TaskFactory
  def initialize
    @sequence = 0
  end
  
  def build(options={})
    options = {
      :name => "Example Task #{self.sequence}"
    }.merge(options)

    Task.new(options)
  end

  def create(options={})
    task = build(options)
    task.save
    task
  end

  def sequence
    @sequence += 1
  end
end
