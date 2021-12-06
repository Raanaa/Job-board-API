class JobRepresenter

  def initialize(job)
      @job = job
  end

  def as_json
  {    
      id: job.id,
      title: job.title,
      description: job.description,
      company: job.company,
      date_added: job.created_at
  }
  end

  private
    attr_reader :job
end