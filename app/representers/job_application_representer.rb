class JobApplicationRepresenter

    def initialize(job_application)
        @job_application = job_application
    end
  
    def as_json
    {    
        id: job_application.id,
        status: job_application.status,
        date_added: job_application.created_at
    }
    end
  
    private
      attr_reader :job_application
  end