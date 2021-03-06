class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy assign update_assignment]
  before_action :authenticate_user!

  # GET /tasks or /tasks.json
  def index
    @selected_user = get_selected_user_from_params
    @tasks = eval(generate_method_chain_str_to_get_specific_tasks)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.author_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def my_tasks
    @tasks = Task.index_all.where(author_id: current_user)
  end

  def assign
  end

  def update_assignment
    if @task.update(assignment_params)
      redirect_to task_url(@task.id)
    else
      render :assign, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :content, :status, :deadline)
  end

  def assignment_params
    params.require(:task).permit(:user_id)
  end

  def generate_method_chain_str_to_get_specific_tasks
    method_chain_str = "Task.all"

    if params[:comp_tasks].nil?
      method_chain_str += ".where.not(status: Task.statuses[:done])"
    end
    if params[:list_desc]
      method_chain_str += ".order(created_at: :desc)"
    end
    if params[:tasks_mine]
      method_chain_str += ".where(user_id: current_user)"
    end
    if params[:task_assignee].present? && params[:task_assignee][:user_id].present?
      task_assignee = params[:task_assignee][:user_id]
      if User.all.where(id: task_assignee).present?
        method_chain_str += ".where(user_id: #{task_assignee})"
      end
    end
    if params[:outdated_tasks]
      method_chain_str += ".where(deadline: ..Time.current)"
    end

    method_chain_str += ".includes(:user)"
    return method_chain_str
  end

  def get_selected_user_from_params
    if params[:task_assignee].present? && params[:task_assignee][:user_id].present?
      selected_user_id = params[:task_assignee][:user_id]
      if User.all.where(id: selected_user_id).present?
        return selected_user_id
      end
    end
    return nil
  end

end
