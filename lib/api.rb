require "api/entities"
require "api/helpers"

module RubyChina
  class API < Grape::API
    prefix "api"
    error_format :json

    helpers APIHelpers

    # Authentication:
    # APIs marked as 'require authentication' should be provided the user's private token,
    # either in post body or query string, named "token"

    resource :topics do
      # Get active topics list
      # params[:size] could be specified to limit the results
      # params[:size]: default is 15, max is 100
<<<<<<< HEAD
=======
      # Example
      #   /api/topics/index.json?size=30
>>>>>>> ruby-china/master
      get do
        @topics = Topic.last_actived
          .limit(page_size)
          .includes(:user)
        present @topics, :with => APIEntities::Topic
      end

<<<<<<< HEAD
=======
      # Get active topics of the specified node
      # params[:id]: node id
      # other params are same to those of topics#index
      # Example
      #   /api/topics/node/1.json?size=30
      get "node/:id" do
        @node = Node.find(params[:id])
        @topics = @node.topics.last_actived
          .limit(page_size)
          .includes(:user)
        present @topics, :with => APIEntities::Topic
      end

>>>>>>> ruby-china/master
      # Post a new topic
      # require authentication
      # params:
      #   title
      #   body
      #   node_id
      post do
        authenticate!
        @topic = current_user.topics.new(:title => params[:title], :body => params[:body])
        @topic.node_id = params[:node_id]
        @topic.save!
        #TODO error handling
      end

<<<<<<< HEAD
=======
      # Get topic detail
      # Example
      #   /api/topics/1.json
>>>>>>> ruby-china/master
      get ":id" do
        @topic = Topic.includes(:replies => [:user]).where(:_id => params[:id]).first
        present @topic, :with => APIEntities::Topic
      end
    end

    resource :nodes do
      # Get a list of all nodes
<<<<<<< HEAD
=======
      # Example
      #   /api/nodes.json
>>>>>>> ruby-china/master
      get do
        present Node.all, :with => APIEntities::Node
      end
    end
  end
end
