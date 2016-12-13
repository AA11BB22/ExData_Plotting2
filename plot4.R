require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get the observations with [Cc][Oo][Aa][Ll] from Short.Name
temp = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE), ]

# Merge it with NEI by SCC
temp <- merge(NEI, temp, by = "SCC")

# Sum Emissions group by year.
temp <- aggregate(Emissions ~ year, temp, sum)

# Plot
ggplot(temp, aes(x = year, y = Emissions)) +
    geom_line(aes(color = Emissions)) + geom_point(aes(color = Emissions)) +
    ggtitle("Coal Combustion-related Sources' Emissions")

dev.copy(png, filename="plot4.png")
dev.off()
