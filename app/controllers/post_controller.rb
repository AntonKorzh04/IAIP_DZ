class PostController < ApplicationController
    def create
        @post = Post.new(date: Date.today, users_id: params[:users_id], workouts_id: params[:workouts_id])
        @post.save
        redirect_to info_news_path
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to info_news_path
    end
end
