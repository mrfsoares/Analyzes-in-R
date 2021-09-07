## Import packages
require("WDI")
require("expss")
require("plotly")

## Import dataset
df <- WDI(indicator = c("EN.ATM.CO2E.PC", "NY.GDP.PCAP.CD"), extra = TRUE)

View(df)

## Generating a backup
bk <- df

## AED
summary(df)

names(df)[names(df)=="EN.ATM.CO2E.PC"] <- "co2"
names(df)[names(df)=="NY.GDP.PCAP.CD"] <- "gdp_pcap"

summary(df['co2'])
summary(df['gdp_pcap'])

# BR
dfbr <- df %>% 
  filter(country == "Brazil") %>% 
  select(country, year, co2, gdp_pcap) 

dfbr$ln_gdp_pcap <- log(dfbr$gdp_pcap)

# Plots BR
use_labels(dfbr, plot(co2~ln_gdp_pcap))


fig <- plot_ly(dfbr, x = ~ln_gdp_pcap, y = ~co2, type = 'scatter', mode = 'markers', 
               size = ~ln_gdp_pcap, color = ~year, colors = 'Paired', sizes = c(10, 50),
               marker = list(opacity = 0.5, sizemode = 'diameter'))

fig <- fig %>% layout(title = 'Brazil: Ln GDP per capita vs. CO2 emissions',
                      xaxis = list(title = "Ln GDP per capita (current US$)", showgrid = FALSE),
                      yaxis = list(title = "CO2 emissions (metric tons per capita)", showgrid = FALSE))

fig
