module Api
    module V1
        class JobApplicationsController < ApplicationController

            before_action :authenticate_request!
            before_action :set_job_application , only: [:show]

            # GET /jobs_applications
            def index
                authorize  JobApplication
                @job_applications = JobApplication.all
                @job_applications.update_all(status: "seen")
                json_response(@job_applications)
            end
    
            def create
                authorize  JobApplication
                @job_application = current_user!.job_applications.create(job_application_params)
                if @job_application.save
                    render json: JobApplicationRepresenter.new(@job_application).as_json, status: :created
                else
                    render json: @job_application.errors, status: :unprocessable_entity
                end
            end
            
            # GET /job applications/:id
            def show
                authorize  @job_application
                @job_application.status = "seen"
                json_response(@job_application)
            end
    
    
            private
    
                def job_application_params
                    params.permit(:status, :user_id , :job_id)
                end
    
                def set_job_application
                    @job_application = JobApplication.find(params[:id])
                end

        end
    end
end
