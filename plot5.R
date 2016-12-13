require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

# Get observations in 1999-2008 and type == "ON-ROAD" and fips == "24510",
#   and select only columns that matter
temp <- subset(NEI,
               year %in% c(1999:2008) &
                   type == "ON-ROAD" &
                   fips == "24510",
               select = c("Emissions", "year"))

# Sum Emissions group by year.
temp <- aggregate(Emissions ~ year, temp, sum)

# Plot
ggplot(temp, aes(x = year, y = Emissions)) +
    geom_line(aes(color = Emissions)) + geom_point(aes(color = Emissions)) +
    ggtitle("Motor Vehicles' Emissions in Maryland")

dev.copy(png, filename="plot5.png")
dev.off()