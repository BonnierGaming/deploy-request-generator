require_relative 'git_info'

# Contains the various snippets of text generated for the mail
class EmailFormatter
  def initialize(special, target_branch_is_master)
    @special = special
    @target_branch_is_master = target_branch_is_master
  end

  attr_reader :special, :target_branch_is_master

  def to
    Settings.email_to
  end

  def subject
    "Deploy request #{special ? '[SPECIAL]' : '[no special]'} for "\
      "\"#{GitInfo.branch_name}\""
  end

  def body
    body_raw = <<BODY
# Branch
#{GitInfo.branch_name}
#{conditional_body_text}
# Commits
#{GitInfo.commit_log}

# Shortstat
#{GitInfo.shortstat}

# Referenced issues
#{GitInfo.issue_urls}
BODY
  end

  def conditional_body_text
    text = ''
    text << "\n# Target branch\n\n" unless target_branch_is_master
    text << "\n# Deploy instructions\n1. \n" if special
    text
  end
end
