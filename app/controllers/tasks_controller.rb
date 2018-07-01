class TasksController < ApplicationController
#before_actionで各メソッドを呼び出す前にメソッドを呼び出す
#onlyでどのメソッドで呼び出すか制限をかける
before_action :set_task, only: [:show,:update,:edit,:delete]

#データ一覧を表示
def index
  @tasks = Task.all
end
#データを閲覧する画面を表示
def show

end
##データを作成する画面を表示
def new
  @tasks = Task.new
end
#データを更新する画面を表示
def edit
end
#データを作成するためのアクション
def create
  @tasks = Task.create(tasks_params)
  if @tasks.save
    redirect_to my_threads_path
  else
    render 'new'
  end
end
#データを更新するためのアクション
def update
end
#データを削除するためのアクション
def destroy
end

end
