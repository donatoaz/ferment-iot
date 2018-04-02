class ScheduleControlLoopsJob < ApplicationJob
  queue_as :control_loops

  def perform
    ControlLoop.all.each do |cl|
      next unless cl.mode == "auto"
      ActiveJob::Base.logger.debug "Checking #{cl.name} for run"
      if Time.now >= cl.next_run
        # enqueue assynchronous action, we don't want to hang around
        # here for too long
        ControlLoopJob.perform_later(cl.id)
        ActiveJob::Base.logger.info "Controle Loop ##{cl.id}:#{cl.name} enqueued to run"
      end

      # Let's test for missed deadlines
      if Time.now >= cl.next_run + cl.sampling_rate.seconds
        # this means the ControlLoopJob is not keeping up
        ActiveJob::Base.logger.error "Controle Loop ##{cl.id}:#{cl.name} is missing deadlines!"
      end
    end
  end
end
