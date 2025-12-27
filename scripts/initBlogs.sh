#!/bin/bash

# ========================================
# Blog Project Generator - Interactive TUI
# ========================================
# TUI: Text-based User Interface
# Purpose: Creates structured blog directories with configurable components
# Why bash?: Lightweight, pre-installed on Unix systems, ideal for file operations

# Function to generate 8-char SHA256 hash
generate_hash() {
    # Why SHA256?: Ensures unique directory names, prevents collisions
    # %s%N: Combines seconds and nanoseconds for higher entropy
    # cut -c1-8: Takes first 8 chars for brevity while maintaining uniqueness
    echo "$(date +%s%N | sha256sum | cut -c1-9)"
}

# Function to display a menu with Yes/No
ask_yes_no() {
    # Local variable: Limits scope to function, prevents namespace pollution
    local prompt="$1"
    local choice

    # While true: Creates persistent prompt until valid input received
    while true; do
        echo "$prompt (y/n): "
        # -r: Raw input, preserves backslashes for escape sequences
        read -r choice

        # Case statement: More efficient than if-elif chain for multiple conditions
        case "$choice" in
            y|Y)
                # Return 0: Standard Unix success code, useful for boolean evaluation
                return 0
                ;;
            n|N)
                # Return 1: Standard Unix error code for false/negative
                return 1
                ;;
            *)
                # Error handling: Guides user to correct input format
                echo "Invalid input. Type 'y' for yes or 'n' for no."
                ;;
        esac
    done
}

# Clear screen and show header
# Clear: Removes previous terminal output for clean interface
clear
echo "======================================="
echo " Blog Project Interactive Generator TUI "
echo "======================================="
echo ""  # Empty line for visual spacing

# Get blog title
# -p: Display prompt before reading input
# blog_title variable: Stores user input for later use
read -p "Enter the blog title or main topic: " blog_title

# Initialize configuration flags with default false values
# Boolean naming convention: Answers "is this feature enabled?"
use_assets=false
has_images=false
is_complex=false

# Conditional feature activation through interactive prompts
# ask_yes_no returns 0 (true) for 'y', 1 (false) for 'n'
if ask_yes_no "Do you want to include custom CSS and JS?"; then
    use_assets=true  # Enables frontend customization
fi

if ask_yes_no "Does this page include images that use relative paths?"; then
    has_images=true  # Creates image directory for media storage
fi

if ask_yes_no "Is this page complex (needs multiple sub-pages)?"; then
    is_complex=true  # Enables multi-page blog structure
fi

# Generate main folder with unique hash
# Why hash directory names?: Prevents conflicts, enables versioning
hash=$(generate_hash)
base_dir="blog/$hash"
# -p: Creates parent directories if they don't exist
mkdir -p "$base_dir"

# Create assets folders based on user input
# Conditional directory creation: Only builds what's needed
if $use_assets; then
    # Standard web asset structure for organization
    mkdir -p "$base_dir/assets/css"    # Stylesheets
    mkdir -p "$base_dir/assets/js"     # JavaScript files
fi

if $has_images; then
    mkdir -p "$base_dir/assets/images" # Image storage with organization
fi

if $is_complex; then
    # Underscore prefix: Convention for special directories in static site generators
    mkdir -p "$base_dir/_pages"        # Sub-pages or partial content
fi

# Create markdown file with blog title as filename
# Why markdown?: Universal, lightweight, convertible to multiple formats
# ${blog_title// /_}: Parameter expansion replacing spaces with underscores
md_file="$base_dir/${blog_title// /_}.md"

# Heredoc (<<) for multi-line file creation with variable interpolation
{
    echo "# $blog_title"                # H1 header with blog title
    echo ""                             # Markdown requires blank line
    echo "## Overview"                  # H2 section
    echo "Write a concise overview of your blog content here."
    echo ""
    echo "## Details"                   # H2 section
    echo "Add detailed explanation, code snippets, references, or images."
    echo ""
    echo "## Assets"                    # H2 section documenting structure
    # Conditional documentation: Only lists created directories
    [[ "$use_assets" == true ]] && echo "- CSS: assets/css" && echo "- JS: assets/js"
    [[ "$has_images" == true ]] && echo "- Images: assets/images"
    [[ "$is_complex" == true ]] && echo "- Additional pages: _pages"
} > "$md_file"  # Output redirection to create file

# Display summary
clear
echo "======================================="
echo " Blog structure created successfully! "
echo "======================================="
echo "Base folder: $base_dir"           # Shows unique hash directory
echo "Main markdown file: $md_file"     # Shows file path for editing
# Conditional output: Only shows created directories
$use_assets && echo "- CSS and JS folders created"
$has_images && echo "- Images folder created"
$is_complex && echo "- _pages folder created"
echo "======================================="
echo "You can now start editing your blog content."
