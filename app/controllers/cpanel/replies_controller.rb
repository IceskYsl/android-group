# coding: utf-8
class Cpanel::RepliesController < Cpanel::ApplicationController
  
  def index
    @replies = Reply.desc(:_id).paginate :page => params[:page], :per_page => 30
  end

  def show
    @reply = Reply.find(params[:id])

    if @reply.topic.blank?
      redirect_to cpanel_replies_path, :alert => "帖子已经不存在"
    end
  end

  def new
    @reply = Reply.new
  end

  def edit
    @reply = Reply.find(params[:id])
  end

  def spam
    @reply = Reply.find(params[:id])
    @reply.update_attribute(:spam, true)
    Akismet.submit_spam(akismet_attributes)
    redirect_to(cpanel_replies_path)
  end
  
  def ham
    @reply = Reply.find(params[:id])
    @reply.update_attribute(:spam, true)
    Akismet.submit_ham(akismet_attributes)
    redirect_to(cpanel_replies_path)
  end
  

  def create
    @reply = Reply.new(params[:reply])

    if @reply.save
      redirect_to(cpanel_replies_path, :notice => 'Reply was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @reply = Reply.find(params[:id])

    if @reply.update_attributes(params[:reply])
       redirect_to(cpanel_replies_path, :notice => 'Reply was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy

    redirect_to(cpanel_replies_path)
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

  
  
end
