/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

using Gtk;

public class Monifor : Window {
    private Scale brightness;

	private string monitor_name;
	private string monitor_resolution;
		
    public Monifor() {
		if(IsExist("/bin/fla") == true) {
			print("Script: FlaScript\n");
			monitor_name = GetCommandOutput("fla --b scripts/monitor_name.fls");
			monitor_resolution = GetCommandOutput("fla --b scripts/monitor_resolution.fls");		
		} else {
			print("Script: Shell Script\n");
			monitor_name = GetCommandOutput("sh scripts/monitor_name.sh");
			monitor_resolution = GetCommandOutput("sh scripts/monitor_resolution.sh");
		}
		
        this.title = monitor_name + " " + monitor_resolution;
        
        this.window_position = WindowPosition.CENTER;
        this.destroy.connect(Gtk.main_quit);
        
        set_default_size(300, 40);
		
        brightness = new Scale.with_range(Orientation.HORIZONTAL, 0, 100, 1);
		
		brightness.adjustment.value_changed.connect (() => {
			  GetCommandOutput("xrandr --output " + monitor_name + " --brightness " + (brightness.adjustment.value / 100).to_string());
        });

        var hbox = new Box(Orientation.HORIZONTAL, 5);
        hbox.homogeneous = true;
        hbox.add(brightness);
        add(hbox);
    }

    public string GetCommandOutput(string command) {
    	string output;
    	string error; 
    	
    	int exit_status;
    	
    	try {
			Process.spawn_command_line_sync (command,
							out output,
							out error,
							out exit_status);
		} catch (SpawnError e) {
			print ("Error: %s\n", e.message);
		}
		
		return output;
    }

    public bool IsExist(string _directory) {
    	if (GLib.FileUtils.test(_directory, GLib.FileTest.EXISTS)) {
			return true;
		}
		
		return false;
    }

    public static int main (string[] args) {
        Gtk.init (ref args);

        var window = new Monifor();
        window.show_all ();

        Gtk.main ();
        return 0;
    }
}
