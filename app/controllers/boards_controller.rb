class BoardsController < ApplicationController
  before_action :set_target_board, only: %i[show edit update destroy]

  def index
    # @boards = Board.all
    @boards = Board.page(params[:page])
  end

  def new
    @board = Board.new(flash[:board])
  end

  def create
    board = Board.new(board_params)
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板を作成しました"
      redirect_to board
    else
      redirect_to :back, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  def show
    # newのしかたを修正。
    # 修正前の書き方では、@board.commentsを一覧表示時、ここでnewした未保存の空のコメントも表示されてしまうため。
    # @comment = @board.comments.new
    @comment = Comment.new(board_id: @board.id)
  end

  def edit
    if flash[:board]
      @board.attributes = flash[:board]
    end
  end

  def update
    # @board.update(board_params)
    # redirect_to @board
    if @board.update(board_params)
      redirect_to @board
    else
      redirect_to :back, flash: {
        board: @board,
        error_messages: @board.errors.full_messages
      }
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, flash: {notice: "「#{@board.title}」の掲示板が削除されました"}
  end

  private

  def board_params
    params.require(:board).permit(:name, :title, :body)
  end

  def set_target_board
    @board = Board.find(params[:id])
   end
end