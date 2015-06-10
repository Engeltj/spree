module Spree
  module Api
    class CountriesController < Spree::Api::BaseController
      skip_before_action :check_for_user_or_api_key
      skip_before_action :authenticate_user

      def index
        @countries = Spree::Country.accessible_by(current_ability, :read).ransack(params[:q]).result.
                     includes(:states).order('name ASC')
                     
        if params[:page] || params[:per_page]
          @countries = @countries.page(params[:page]).per(params[:per_page])
        end
                     
        country = Spree::Country.order("updated_at ASC").last
        if stale?(country)
          respond_with(@countries)
        end
      end

      def show
        @country = Spree::Country.accessible_by(current_ability, :read).find(params[:id])
        respond_with(@country)
      end
    end
  end
end
