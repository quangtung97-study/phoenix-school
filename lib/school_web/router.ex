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

    get "/manage/", ManageController, :index
    post "/manage/new/", ManageController, :new_account
    post "/manage/delete/", ManageController, :delete_accounts

    post "/manage/add/admin", ManageController, :add_admin
    post "/manage/add/saodo", ManageController, :add_saodo
    post "/manage/add/loptruong", ManageController, :add_loptruong

    post "/manage/remove/admin/", ManageController, :remove_admins
    post "/manage/remove/saodo/", ManageController, :remove_saodos
    post "/manage/remove/loptruong/", ManageController, :remove_loptruongs

    post "/manage/new/class/", ManageController, :new_class
    post "/manage/delete/class/", ManageController, :delete_classes

    get "/hoctap/", HoctapController, :index
    get "/hoctap/admin/:class_id/:week_start_date", HoctapController, :index

    post "/hoctap/add/", HoctapController, :add
    post "/hoctap/update/", HoctapController, :update
    post "/hoctap/delete/", HoctapController, :delete

    get "/nenep/", NenepController, :index
    get "/nenep/saodo/", NenepController, :index_saodo
    get "/nenep/saodo/:class_id", NenepController, :index_saodo
    get "/nenep/admin/", NenepController, :index_admin
    get "/nenep/admin/:class_id/:week_start_date", NenepController, :index_admin

    post "/nenep/add/", NenepController, :add
    post "/nenep/update/", NenepController, :update
    post "/nenep/delete/", NenepController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", SchoolWeb do
  #   pipe_through :api
  # end
end
