/*
7/22/2025, 7:35PM, like done untested. X E.
*/
/*
5/13/2025, 4:31PM, start on merger thing. X E.
4:38PM, done pair sort thing.
4:48PM, 4:49PM, done local merge. X E.
5:00PM, done global sort. X E.
5:02PM, pair sort saved. X E.
5:08PM, This is modified from a code from Grok made by xAI. 5:09PM, X E.
6/4/2025, 6:34PM, done. X E.
7/2/2025, 12:35PM, done. X E.
1:46PM, done. X E.
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
// Pair sort shader: Generates and sorts pairs, assigning to drawOrder
[shader("compute")]
[numthreads(256, 1, 1)]
void pairSortMain(uint3 dispatchThreadID : SV_DispatchThreadID) {
    uint idx1 = dispatchThreadID.x * 2;
    if (idx1 < shapeNumber) {
        uint idx2 = idx1 + 1;
        if (idx2 < shapeNumber) {
            // Compare and assign sorted pair
            if (zDists[idx1][0]>zDists[idx2][0]) {
                drawOrder[idx1] = idx1;
                drawOrder[idx2] = idx2;
            } else if (zDists[idx1][0]<zDists[idx2][0]) {
                drawOrder[idx1] = idx2;
                drawOrder[idx2] = idx1;
            } else if (zDists[idx1][1]>zDists[idx2][1]) {
                drawOrder[idx1] = idx1;
                drawOrder[idx2] = idx2;
            } else {
                drawOrder[idx1] = idx2;
                drawOrder[idx2] = idx1;
            }
        } else {
            // Assign unpaired index for odd n
            drawOrder[idx1] = idx1;
        }
    }
    //X E
}
//X E
