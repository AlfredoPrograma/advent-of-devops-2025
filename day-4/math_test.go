package day4

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestAdd(t *testing.T) {
	type testCase struct {
		n1             int
		n2             int
		expectedResult int
	}

	testCases := []testCase{
		{
			n1:             5,
			n2:             10,
			expectedResult: 15,
		},
		{
			n1:             1,
			n2:             0,
			expectedResult: 1,
		},
	}

	for _, tc := range testCases {
		t.Run("should add two numbers", func(t *testing.T) {
			result := Add(tc.n1, tc.n2)
			assert.Equal(t, result, tc.expectedResult)
		})
	}
}

func TestMultiply(t *testing.T) {
	type testCase struct {
		n1             int
		n2             int
		expectedResult int
	}

	testCases := []testCase{
		{
			n1:             5,
			n2:             10,
			expectedResult: 50,
		},
		{
			n1:             1,
			n2:             0,
			expectedResult: 0,
		},
	}

	for _, tc := range testCases {
		t.Run("should multiply two numbers", func(t *testing.T) {
			result := Multiply(tc.n1, tc.n2)
			assert.Equal(t, tc.expectedResult, result)
		})
	}
}
