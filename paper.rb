class Paper
  attr_accessor :content, :meta

  def initialize(paper_markdown)
    if paper_markdown =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
      @content = $'
      @meta = YAML.load($1)
    end
  end

  def running_head
    "Running Head: #{@meta['Title']}".upcase
  end

  def last_name
    @meta['Last Name']
  end

  def name
    "#{@meta['First Name']} #{@meta['Last Name']}"
  end

  def title
    @meta['Title']
  end

  def title
    @meta['Title']
  end

  def school
    @meta['School']
  end

  def teacher
    @meta['Teacher']
  end

  def course
    @meta['Course']
  end

  def due_date
    @meta['Due Date']
  end

  def abstract
    @meta['Abstract']
  end

  def body
    @content
  end

  def get_format
    @format ||= @meta['Format'].downcase
  end

  def get_template
    "formats/#{self.get_format()}.html.haml"
  end

  def to_pdf
    haml = Haml::Engine.new File.read(self.get_template())
    output = haml.render(Object.new, paper: self)
    prince = Prince.new
    return prince.html_to_string(output)
  end
end