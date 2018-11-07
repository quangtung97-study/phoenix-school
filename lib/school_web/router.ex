defmodule SchoolWeb.Router do
  use SchoolWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SchoolWeb do
    pipe_through :browser # Use the default browser stack

    get "/", HomeController, :index

    get "/account/", AccountController, :index
    get "/account/login", AccountController, :login
    get "/account/succeed", AccountController, :succeed
    post "/account/login", AccountController, :login_post
    post "/account/logout", AccountController, :logout
    post "/account/change-password", AccountController, :change_password

    get "/hoctap/", HoctapController, :index

    get "/manage/", ManageController, :index
    post "/manage/new/", ManageController, :new_account
    post "/manage/delete/", ManageController, :delete_accounts
  end

  # Other scopes may use custom stacks.
  # scope "/api", SchoolWeb do
  #   pipe_through :api
  # end
end
