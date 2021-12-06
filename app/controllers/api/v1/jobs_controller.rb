module Api
    module V1
        class JobsController < ApplicationController
        before_action :authenticate_request!
        before_action :set_job, only: [:show, :update, :destroy]

        # GET /jobs
        def index
            @jobs = Job.all
            json_response(@jobs)
        end

        def create
            authorize Job
            @job = current_user!.jobs.create(job_params)
            if @job.save
                render json: JobRepresenter.new(@job).as_json, status: :created
            else
                render json: @job.errors, status: :unprocessable_entity
            end
        end
        
        # GET /jobs/:id
        def show
            json_response(@job)
        end

        # PUT /jobs/:id
        def update
            authorize  @job
            @job.update(job_params)
            json_response(@job)
        end

        # DELETE /jobs/:id
        def destroy
            authorize  @job
            @job.destroy
            render json: " Job with id = #{@job.id} is destroyed"
        end

        private

            def job_params
            params.permit(:title, :description, :company, :user_id)
            end

            def set_job
            @job = Job.find(params[:id])
            end

        end
    end
end