/*
7/22/2025, 7:41PM, like done untested. X E
*/
/*
5/13/2025, 4:11PM, start making reverse x. X E.
4:15PM, done. X E. 4:19PM, done better. X E.
4:19PM, done reverse y. X E.
6/4/2025, 6:35PM, done. X E.
7/2/2025, 6:21PM, done. X E.
7/8/2025, 6:33PM, done. X E.
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
//Main shader
[shader("compute")]
[numthreads(256, 1, 1)]
void reverseYMain(uint3 dispatchThreadID : SV_DispatchThreadID) {
    //Only process as many as shapeNumber.
    if (dispatchThreadID.x>=pointNumber) {
        //X E
        return;
        //X E
    }
    if (!isnan(points2d[dispatchThreadID.x][0])&&!isnan(points2d[dispatchThreadID.x][1])) {
        points2d[dispatchThreadID.x][1] = -points2d[dispatchThreadID.x][1];
    }
    //X E
}
//X E
