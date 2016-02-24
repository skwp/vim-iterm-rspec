" Don't try to load if we don't have Ruby support.
if !has("ruby")
  finish
endif

command! RunItermSpec :ruby ITerm.rspec
command! RunItermSpecLine :ruby ITerm.rspec_line

command! RunItermSpringSpec :ruby ITerm.spring_rspec
command! RunItermSpringSpecLine :ruby ITerm.spring_rspec_line

command! RunItermZeusSpec :ruby ITerm.zeus_rspec
command! RunItermZeusSpecLine :ruby ITerm.zeus_rspec_line

let g:iterm_rspec_version='legacy'

ruby <<EOF

module ITerm

  def self.rspec_line
    rspec(":#{current_line}")
  end

  def self.rspec(options="")
    exec("rspec #{current_file}#{options}")
  end

  def self.spring_rspec_line
    spring_rspec(":#{current_line}")
  end

  def self.spring_rspec(options="")
    exec("spring rspec #{current_file}#{options}")
  end

  def self.zeus_rspec_line
    zeus_rspec(":#{current_line}")
  end

  def self.zeus_rspec(options="")
    exec("zeus rspec #{current_file}#{options}")
  end


  private


  def self.current_file
    current_buffer.name
  end

  def self.current_line
    current_buffer.line_number
  end

  def self.current_buffer
    VIM::Buffer.current
  end

  APPLESCRIPT_VERSIONS = {
    'legacy' => {
      :app_name => 'iTerm',
      :current_session => 'current session of the current terminal',
      :new_window => '(make new terminal)',
      :launch_session => 'launch session "Default"'
    },
    '2.9' => {
      :app_name => 'iTerm2',
      :current_session => 'current session of first window',
      :new_window => '(create window with profile "Default")',
      :launch_session => '' # Session is launched with window
    }
  }

  def self.exec(command)
    iterm_version = Vim.evaluate('g:iterm_rspec_version')
    as_commands = APPLESCRIPT_VERSIONS[iterm_version]
    osascript <<-EOF
      tell application "#{as_commands[:app_name]}"
        try
          set mySession to the #{as_commands[:current_session]}
        on error
          set myTerminal to #{as_commands[:new_window]}
          tell myTerminal
            #{as_commands[:launch_session]}
            set mySession to the current session
          end tell
        end try
        tell mySession to write text "#{command}"
        activate
      end tell
    EOF
  end

private

  def self.osascript(script)
    system("osascript", "-e", script)
  end

end

EOF
