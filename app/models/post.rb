# coding: utf-8
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::SoftDelete
  include Mongoid::BaseModel
  include Redis::Objects

  STATE = {
    :draft => 0,
    :normal => 1
  }

  field :title, :type => String
  field :body, :type => String
  field :state, :type => Integer, :default => STATE[:draft]
  field :tags, :type => Array, :default => []
  # 来源名称
  field :source
  # 来源地址
  field :source_url
  field :comments_count, :type => Integer, :default => 0
  belongs_to :user

  index :tags
  index :user_id
  index :state

  counter :hits, :default => 0

  attr_accessible :title, :body, :tag_list, :source, :source_url
  attr_accessor :tag_list

  validates_presence_of :title, :body, :tag_list

  scope :normal, where(:state => STATE[:normal])
  scope :by_tag, Proc.new { |t| where(:tags => t) }

  before_save :split_tags

  def similars
    tags = self.tags
    tags.blank? ?  [] : Post.normal.by_tag(tags.first).limit(5)
  end
  
  def self.hots_tags(limit=10)
    o = []
    Post.normal.to_a.reject{ |p| p['tags'].blank? }.select{|p| o <<  p.tags}
    tags =  o.flatten.inject({}) {|hash, item| hash[item] ||= 0; hash[item] += 1; hash }.to_a.sort{|a,b| b[1] <=> a[1]}[0..limit]
    # logger.info "tags;#{tags}"
    tags
  end
  

  def split_tags
    if !self.tag_list.blank? and self.tags.blank?
      self.tags = self.tag_list.split(/,|，/).collect { |tag| tag.strip }.uniq
    end
  end

  # 给下拉框用
  def self.state_collection
    STATE.collect { |s| [s[0], s[1]]}
  end

end
