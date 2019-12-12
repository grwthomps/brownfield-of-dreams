desc "Set any nil video positions to 0"
task :video_position => [:environment] do
  Video.where(position: nil).update_all(position: 0)
end
