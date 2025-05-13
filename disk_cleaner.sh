#!/bin/bash

echo "========== Disk Cleaner Utility =========="

echo ""
echo "Disk usage before cleanup: "
df -h
echo ""

PS3="Select an option (1-6): "
options=("Clean Apt Cache" "Delete Log Files " " Empty Trash" "Clean /temp" "Clean Everything" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Clean Apt Cache")
            echo "Cleaning apt cache..."
            sudo apt clean
            echo "Done."
            ;;
        "Delete Log Files")
            echo "Deleting log files in /var/log..."
            sudo find /var/log -type f -name "*.log" -delete
            echo "Done."
            ;;
        "Empty Trash")
            echo "Emptying trash..."
	    rm -rf ~/.local/share/Trash/*
	    echo "Done."
	    ;;
	"Clean /temp")
	    echo "Cleaning /tmp directory..."
	    sudo find /tmp -type f -mtime +7 -exec rm -f {} \;
	    echo "Done."
	    ;;
	"Clean Everything")
	    echo "Running full cleanup..."
	    sudo apt clean
            sudo find /var/log -type f -name "*.log" -delete
	    rm -rf ~/.local/share/Trash/*
	    sudo find /tmp -type f -mtime +7 -exec rm -f {} \;
	    echo "All cleanups complete."
	    ;;
	"Quit")
	    echo "Exiting Disk Cleaner, Goodbye!"
	    break
	    ;;
	*) echo "Invalid option. Please try again." ;;
    esac
    echo "" 
done

echo ""
echo "Disk usage after cleanup: "
df -h

