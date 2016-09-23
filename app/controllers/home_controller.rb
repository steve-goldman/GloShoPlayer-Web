class HomeController < ApplicationController
  def index
    @serverUrl       = params[:serverUrl]       || DEFAULT_SERVER_URL
    @doneDelay       = params[:doneDelay]       || DEFAULT_DONE_DELAY
    @locateMeSeconds = params[:locateMeSeconds] || DEFAULT_LOCATE_ME_SECONDS
    @loginInterval   = params[:loginInterval]   || DEFAULT_LOGIN_INTERVAL
  end
end
