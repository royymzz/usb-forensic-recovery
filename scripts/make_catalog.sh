#!/bin/bash

output="PDF_Catalog.csv"

echo '"File","Title","Author","Pages","Software","Security","Size"' > "$output"

find . -type f -name '*.pdf' | while IFS= read -r file; do
    title=$(mdls -raw -name kMDItemTitle "$file" 2>/dev/null)
    author=$(mdls -raw -name kMDItemAuthors "$file" 2>/dev/null | tr '\n' ' ')
    pages=$(mdls -raw -name kMDItemNumberOfPages "$file" 2>/dev/null)
    software=$(mdls -raw -name kMDItemEncodingApplications "$file" 2>/dev/null | tr '\n' ' ')
    security=$(mdls -raw -name kMDItemSecurityMethod "$file" 2>/dev/null)
    size=$(mdls -raw -name kMDItemFSSize "$file" 2>/dev/null)

    title=${title//\"/\"\"}
    author=${author//\"/\"\"}
    software=${software//\"/\"\"}
    security=${security//\"/\"\"}

    printf '"%s","%s","%s","%s","%s","%s","%s"\n' \
        "$file" "$title" "$author" "$pages" "$software" "$security" "$size" >> "$output"
done

echo "Catalog saved as $output"
