class ConversationsController < InheritedResources::Base
  actions :index, :new, :create, :destroy

  before_filter :authenticate_user!

  before_filter :target_user, only: [ :new ]

  def index
    @conversatons ||= current_user.inbox_conversations
    @sent_box_conversations = current_user.conversations
  end

  def create
    @conversation = end_of_association_chain.new(conversation_params)

    create! { root_path }
  end

  def show
    @conversation = Conversation.find(params[:id])
    @conversation.mark_as_read!
  end

  protected

  def begin_of_association_chain
    current_user
  end

  def conversation_params
    params.require(:conversation).permit!
  end

  def target_user
    @target_user = User.find_by_id(params[:user_id])
  end
end
