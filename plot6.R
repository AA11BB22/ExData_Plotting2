require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

# Select observations in 1999-2008 and type == "ON-ROAD" and fips == "24510" or "06037",
#   and select only columns that matter
temp <- subset(NEI,
               year %in% c(1999:2008) &
                   type == "ON-ROAD" &
                   fips %in% c("24510", "06037"), 
               select = c("fips", "Emissions", "year"))

# Sum Emissions group by year and fips.
temp <- aggregate(Emissions ~ year + fips, temp, sum)

# Rename fips
temp$fips <- sapply(temp$fips, function (x) {ifelse(x == "24510", "Maryland", "Los Angeles")})

# Plot
ggplot(temp, aes(x = year, y = Emissions)) + 
    geom_line(aes(color = fips)) +
    geom_point(aes(color = fips), size = 3) +
    ylab("Emission") +
    xlab("Year") +
    aes(title = "Maryland's and Los Angeles's PM2.5 Emissions")

dev.copy(png, filename="plot6.png")
dev.off()