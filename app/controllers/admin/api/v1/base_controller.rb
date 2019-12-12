class Admin::Api::V1::BaseController < Admin::BaseController
  before_action :require_admin!
end
