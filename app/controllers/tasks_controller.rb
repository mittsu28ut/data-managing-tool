class TasksController < ApplicationController
#before_actionで各メソッドを呼び出す前にメソッドを呼び出す
#onlyでどのメソッドで呼び出すか制限をかける
before_action :set_task, only: [:show,:update,:edit,:destroy]

#データ一覧を表示
def index
  @tasks = Task.all
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
  respond_to do |format|
    if @task.save
      format.html {redirect_to @task, notice: 'Task was successfully created.'}
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
      format.html { redirect_to @task, notice: "Task was successfully updated." }
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
    format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
    format.json { head :no_content }
  end
end

private
  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:name, :detail, :due, :priority)
  end
end
