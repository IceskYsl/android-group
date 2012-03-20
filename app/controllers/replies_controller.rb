# coding: utf-8
class RepliesController < ApplicationController

  load_and_authorize_resource :reply

  before_filter :find_topic
  def create

    @reply = @topic.replies.build(params[:reply])

    @reply.user_id = current_user.id
    @reply.spam = Akismet.spam?(akismet_attributes, request)
    logger.info("akismet_attributes:#{akismet_attributes}")
    logger.info("@reply.spam:#{@reply.spam}")
    if @reply.save
      current_user.read_topic(@topic)
      @msg = t("topics.reply_success")
    else
      @msg = @reply.errors.full_messages.join("<br />")
    end
  end

  def edit
    @reply = Reply.find(params[:id])
    drop_breadcrumb(t("menu.topics"), topics_path)
    drop_breadcrumb t("reply.edit_reply")
  end

  def update
    @reply = Reply.find(params[:id])

    if @reply.update_attributes(params[:reply])
      redirect_to(topic_path(@reply.topic_id), :notice => '回帖更新成功.')
    else
      render :action => "edit"
    end
  end

  protected
  def akismet_attributes
    {
      :comment_author       => @reply.user.login,
      :comment_author_url   => user_url(@reply.user.login),
      :comment_author_email => @reply.user.email,
      :comment_content      => @reply.body,
      :permalink            => topic_url(@reply.topic_id)
    }
  end


  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

end
