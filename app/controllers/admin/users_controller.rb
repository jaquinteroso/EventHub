module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:edit, :update, :destroy]

    def index
      @users = User.order(:full_name, :email)
    end

    def edit
      authorize! :update, @user
    end

    def update
      authorize! :update, @user

      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize! :destroy, @user

      if @user == current_user
        redirect_to admin_users_path, alert: "You cannot delete your own account from the admin area."
      elsif @user.destroy
        redirect_to admin_users_path, notice: "User was successfully deleted."
      else
        redirect_to admin_users_path, alert: @user.errors.full_messages.to_sentence
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:full_name, :email, :role)
    end
  end
end
