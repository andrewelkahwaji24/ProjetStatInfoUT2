import geopandas as gpd

# Load the Shapefile
gdf = gpd.read_file("10005.dwg")

# Convert and save as GeoJSON
gdf.to_file("output_file.geojson", driver="GeoJSON")
