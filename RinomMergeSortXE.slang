/*
7/22/2025, 6:03PM, start. X E.
7:32PM, like done untested. X E.
7:50PM, like done, untested. X E.
8:41PM, like done, untested. X E.
*/
/*
7/26/2023, 12:32PM, start.
Started by Norvel M. IV, Josiah.
Started on Ubuntu Touch using uText.
I define "X E" and "XE" ending things to mean:
"All that is near and with this me and since like my last adequate uncertainty to this me as per one might be input maybe or might not be input maybe or might be output maybe or might not be output maybe, maybe or maybe not, maybe.".
In a sentence, "A" may be lower case and if a period is after "X E" then period may be omitted from that definition.
This Rinom is intended to allow drawing in 3 or more dimensions using dimension axes on a 2 dimensional screen.
X E.
*/
// Define the input and output buffers
RWStructuredBuffer<float> points;
RWStructuredBuffer<float2> points2d;
RWStructuredBuffer<uint> shapes;
RWStructuredBuffer<uint> shapeEnds;
RWStructuredBuffer<float2> zDists;
RWStructuredBuffer<uint> drawOrder;
// Constant buffer for parameters
cbuffer ComputeParams {
    uint3 xyz;           // 3 integers for x, y, z
    uint unitSize;       // Number of floats per unit
    uint pointNumber;    // Number of points
    uint shapeNumber;    // Number of shapes
    float3 constants;   // 3 float constants
    float2 offset2d;    // 2d offsets
    uint shouldRound;   // Whether to round
    float roundWith;    // What to round with
    float precPad;      // Precision padding
    //X E
};
//X E
uniform uint step; // step is number to do to other number of it e.g. 2 to 2 or 1 to 1.
//X E

//Note that any more elements than half what a 32 bit number can hold may have bad behavior.
// Compute shader entry point
[shader("compute")]
[numthreads(256, 1, 1)] // Thread group size, adjustable
void mergeSortMain(uint3 dispatchThreadID : SV_DispatchThreadID) {
    //Exit early if index is out of bounds or buffer is 1 or less.
    if (dispatchThreadID.x*step*2+step >= shapeNumber || shapeNumber == 0 || shapeNumber == 1) {
        //X E
        return;
        //X E
    }
    //Start merge sort
    uint4 indices = uint4(dispatchThreadID.x*step*2+step,dispatchThreadID.x*step*2,0,0);
    uint3 indices1 = uint3(0,0,dispatchThreadID.x*step*2+step*2);
    //Find end, shapeNumber or less.
    if (indices1[2]>shapeNumber) {
        indices1[2]=shapeNumber;
    }
    while (indices1[2] != indices[0]) {
        if (zDists[indices[0]][0] < -0.0) {
            //We have reached invalid data and do not need to continue. X E
            return;
            //X E
        } else {
            //Set up bounds. indices[1] is preset.
            indices[2]=indices[0]-1;
            //Loop and find where to input.
            while (indices[1]<indices[2]) {
                //Compare and eliminate all possibilities including current one. Round up.
                indices1[1]=(indices[1]+indices[2]+1)/2;
                indices1[0]=drawOrder[indices1[1]];
                if (zDists[indices[0]][0]>zDists[indices1[0]][0]) {
                    indices[2]=indices1[1]-1;
                } else if (zDists[indices[0]][0]<zDists[indices1[0]][0]) {
                    indices[1]=indices1[1]+1;
                } else if (zDists[indices[0]][1]>zDists[indices1[0]][1]) {
                    indices[2]=indices1[1]-1;
                } else if (zDists[indices[0]][1]<zDists[indices1[0]][1]) {
                    indices[1]=indices1[1]+1;
                } else {
                    //Equal numbers found, set to go after it.
                    indices[1]=indices1[1]+1;
                    break;
                }
            }
            if (indices[1]==indices[2]) {
                //Compare and find proper place.
                indices1[0]=drawOrder[indices[1]];
                if (zDists[indices[0]][0]<zDists[indices1[0]][0]||(zDists[indices[0]][0]==zDists[indices1[0]][0]&&zDists[indices[0]][1]<zDists[indices1[0]][1])) {
                    indices[1]+=1;
                }
            }
            //Move all at or above found up one.
            if (indices[1]<indices[0]) {
                //Save a copy of the current index
                indices[3]=drawOrder[indices[0]];
                indices[2]=indices[0];
                //Shift.
                while (indices[1] != indices[2]) {
                    drawOrder[indices[2]]=drawOrder[indices[2]-1];
                    indices[2]-=1;
                }
                //Put index where it should be.
                drawOrder[indices[1]]=indices[3];
                //If up to end of possibilities do not continue sorting.
                if (indices[1]==indices[0]) {
                    //X E
                    return;
                    //X E
                }
                indices[1]+=1;
            } else {
                //End of sorting needs by already sorted parts. X E
                return;
                //X E
            }
        }
        //increment
        indices[0]+=1;
    }
    //X E
}
//X E
