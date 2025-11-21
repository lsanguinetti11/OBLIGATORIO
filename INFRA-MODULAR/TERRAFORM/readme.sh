
#!/bin/bash
# Generar un README único con todos los módulos

OUTPUT_FILE="README.md"
MODULES_DIR="modules"

# Limpiar el archivo si existe
> "$OUTPUT_FILE"

# Documentación del módulo root
echo "# Documentación del Proyecto" >> "$OUTPUT_FILE"
echo -e "\n## Root Module\n" >> "$OUTPUT_FILE"
terraform-docs markdown table . >> "$OUTPUT_FILE"

# Documentación de cada submódulo
for module in "$MODULES_DIR"/*; do
  if [ -d "$module" ]; then
    MODULE_NAME=$(basename "$module")
    echo -e "\n## Módulo: $MODULE_NAME\n" >> "$OUTPUT_FILE"
    terraform-docs markdown table "$module" >> "$OUTPUT_FILE"
  fi
done

echo "✅ README.md generado con toda la documentación."
