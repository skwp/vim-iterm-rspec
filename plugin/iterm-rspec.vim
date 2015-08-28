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


  def self.exec(command)
    osascript <<-EOF
      tell application "iTerm"
        try
          set mySession to the current session of the current terminal
        on error
          set myTerminal to (make new terminal)
          tell myTerminal
            launch session "Default"
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
