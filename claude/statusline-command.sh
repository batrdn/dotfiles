#!/usr/bin/env bash

input=$(cat)

GREEN="\033[32m"
DARK_GRAY="\033[90m"
RESET="\033[0m"

full_model=$(echo "$input" | jq -r '.model.display_name')
model_short="${full_model#Claude }"

used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used" ]; then
  printf -v used_int "%.0f" "$used"
  bar_width=20
  filled=$(( used_int * bar_width / 100 ))
  empty=$(( bar_width - filled ))
  filled_bar=""
  empty_bar=""
  for (( i=0; i<filled; i++ )); do filled_bar="${filled_bar}█"; done
  for (( i=0; i<empty;  i++ )); do empty_bar="${empty_bar}░"; done
  used_label="[${GREEN}${filled_bar}${DARK_GRAY}${empty_bar}${RESET}] ${used_int}%"
else
  used_label="[${DARK_GRAY}░░░░░░░░░░░░░░░░░░░░${RESET}] --%"
fi

permission_mode=$(echo "$input" | jq -r '.permissionMode // ""')
if [[ "$permission_mode" == *"bypass"* || "$permission_mode" == *"dangerouslySkipPermissions"* || "$permission_mode" == *"skip"* ]]; then
  lock="🔓"
else
  lock="🔒"
fi

total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

if [[ "$full_model" == *"Opus"* ]]; then
  price_in=15
  price_out=75
elif [[ "$full_model" == *"Haiku"* ]]; then
  price_in=0.80
  price_out=4
else
  price_in=3
  price_out=15
fi

cost=$(awk "BEGIN { printf \"%.2f\", ($total_in / 1000000 * $price_in) + ($total_out / 1000000 * $price_out) }")

format_tokens() {
  local n=$1
  if (( n >= 1000000 )); then
    awk "BEGIN { printf \"%.1fM\", $n / 1000000 }"
  elif (( n >= 1000 )); then
    awk "BEGIN { printf \"%.1fk\", $n / 1000 }"
  else
    echo "$n"
  fi
}

in_fmt=$(format_tokens "$total_in")
out_fmt=$(format_tokens "$total_out")

printf '%b\n' "$model_short | $used_label | $lock"
printf '%b\n' "${DARK_GRAY}tokens:${RESET} ${in_fmt}${DARK_GRAY}in /${RESET} ${out_fmt}${DARK_GRAY}out · ~\$${RESET}${cost}"
