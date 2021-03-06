# == Schema Information
#
# Table name: toys
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  name       :string           not null
#  ttype      :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class ToysController < ApplicationController
  def index
    cat = Cat.find(params[:cat_id])
    render json: cat.toys
  end

  def show
    render json: Toy.find(params[:id])
  end

  def create
    # POST /cats/:cat_id/toys
    # POST /toys

    # Strong Parameters
    # self.params => Paramaters < HashWithIndifferentAccess < Hash
    @toy = Toy.new(toy_params)
    @cat = @toy.cat

    if @toy.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def new
    @cat = Cat.find(params[:cat_id])
    @toy = Toy.new
    render :new
  end

  def destroy
    toy = Toy.find(params[:id])
    toy.destroy
    render json: toy
  end

  def update
    toy = Toy.find(params[:id])

    success = toy.update(toy_params)
    if success
      render json: toy
    else
      render json: toy.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def toy_params
    params[:toy].permit(:cat_id, :name, :ttype)
  end
end
