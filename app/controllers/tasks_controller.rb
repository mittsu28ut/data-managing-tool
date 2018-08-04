class TasksController < ApplicationController
#before_actionで各メソッドを呼び出す前にメソッドを呼び出す
#onlyでどのメソッドで呼び出すか制限をかける
before_action :set_task, only: [:show,:update,:edit,:destroy]
helper_method :sort_column, :sort_direction
#データ一覧を表示
def index
  @task = Task.new
  @tasks = current_user.tasks.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page:8)
  if params[:name].present?
    @tasks = @tasks.get_by_name params[:name]
  end
  if params[:status].present?
    @tasks = @tasks.get_by_status params[:status]
  end
end
#データを閲覧する画面を表示
def show

end
##データを作成する画面を表示
def new
  @task = Task.new
end
#データを更新する画面を表示
def edit
end
#データを作成するためのアクション
def create
  @task = Task.new(task_params)
  @task.user = current_user
  respond_to do |format|
    if @task.save
      format.html {redirect_to @task, notice: t(".success")}
      format.json {render :show, status: :created, location: @task}
    else
      format.html { render :new}
      format.json { render json: @task.errors, status: :unprocessable_entity}
    end
  end
end
#データを更新するためのアクション
def update
  respond_to do |format|
    if @task.update(task_params)
      format.html { redirect_to @task, notice: t(".success") }
      format.json { render :show, status: :ok, location: @task }
    else
      format.html { render :edit }
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end
end
#データを削除するためのアクション
def destroy
  @task.destroy
  respond_to do |format|
    format.html { redirect_to tasks_url, notice: t(".success") }
    format.json { head :no_content }
  end
end

def sort

end

private
  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:name, :detail, :due, :priority, :status)
  end
  def sort_column
    #Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    params[:sort] || "created_at"
  end
  def sort_direction
    #%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    params[:direction] || "asc"
  end
end
