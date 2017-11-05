require_relative '../test_helper'
require 'gnome_app_driver'

describe 'test driving a dummy application' do
  before do
    @driver = GnomeAppDriver.new('dummy', app_file: 'test/bin/dummy')
    @driver.boot
  end

  it 'starts and can be quit with Ctrl-q' do
    @driver.press_ctrl_q

    status = @driver.cleanup
    status.exitstatus.must_equal 0
  end

  after do
    @driver.cleanup
  end
end

describe 'test driving an application without an accessible window' do
  before do
    @driver = GnomeAppDriver.new('dummy', app_file: 'test/bin/no_window')
  end

  it 'will fail to boot' do
    proc { @driver.boot }.must_raise RuntimeError, /App not/
  end

  after do
    @driver.cleanup
  end
end
