package do1

import (
	"testing"
)

func TestSoltuion(t *testing.T) {
	got := Do1()
	want := 3
	if got != want {
		t.Errorf("Do1() = %d; want %d", got, want)
	}
}
