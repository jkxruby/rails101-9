class WelcomeController < ApplicationController

def index
  flash[:notice] = "hello world!"
end

end
