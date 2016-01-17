module TimecopConsole
  class MainController < ::ApplicationController
    skip_filter :handle_timecop_offset

    def update
      if date_select_format?
        year   = params['timecop']['current_time(1i)'].to_i
        month  = params['timecop']['current_time(2i)'].to_i
        day    = params['timecop']['current_time(3i)'].to_i
        hour   = params['timecop']['current_time(4i)'].to_i
        minute = params['timecop']['current_time(5i)'].to_i
        second = Time.now.sec
      else
        # backward compatible format
        year   = params[:year].to_i
        month  = params[:month].to_i
        day    = params[:day].to_i
        hour   = params[:hour].to_i
        minute = params[:min].to_i
        second = params[:sec].to_i
      end

      session[SESSION_KEY_NAME] = Time.zone.local(year, month, day, hour, minute, second)
      redirect_to :back
    end

    def reset
      session[SESSION_KEY_NAME] = nil
      redirect_to :back
    end

    private

      # http://api.rubyonrails.org/classes/ActionView/Helpers/DateHelper.html#method-i-date_select
      def date_select_format?
        params['timecop'].present? && params['timecop']['current_time(1i)'].present?
      end
  end
end
