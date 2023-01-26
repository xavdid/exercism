// Package weather does a thing.
package weather

// CurrentCondition is a value.
var CurrentCondition string

// CurrentLocation is a value.
var CurrentLocation string

// Forecast finally, this is a function.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
