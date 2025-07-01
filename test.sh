for dir in pipeline_* config_*; do
  if [ -d "$dir" ]; then
    echo "Found folder: $dir"
  fi
done
