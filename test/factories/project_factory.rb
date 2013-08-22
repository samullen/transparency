class ProjectFactory
  def initialize
    @sequence = 0
  end
  
  def build(options={})
    options = {
      :name => "Example Project #{self.sequence}"
    }.merge(options)

    Project.new(options)
  end

  def create(options={})
    project = build(options)
    project.save
    project
  end

  def sequence
    @sequence += 1
  end
end
