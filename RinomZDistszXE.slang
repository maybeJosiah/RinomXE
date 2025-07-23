/*
7/22/2025, 7:42PM, like done untested. X E.
7/23/2025, 11:24AM, begin revamp. X E.
11:27AM, done. X E.
*/
/*
5/9/2025, 12:15PM, start get z and 2d distance. X E.
12:20PM, save first. X E.
12:53PM, like done, untested. X E.
12:54PM, X E.
1:07PM, X E.
5/13/2025, 4:08PM, done. X E.
4:24PM, done. X E.
5/22/2025, 6:40PM, done. X E.
6/4/2025, 6:36PM, done. X E.
7/2/2025, 6:22PM, done. X E.
7/8/2025, 6:34PM, done. X E.
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
void zDistMain(uint3 dispatchThreadID : SV_DispatchThreadID) {
    //Only process as many as shapeNumber.
    if (dispatchThreadID.x>=shapeNumber) {
        //X E
        return;
        //X E
    }
    if (shapeEnds[dispatchThreadID.x+1]==shapeEnds[dispatchThreadID.x]) {
        zDists[dispatchThreadID.x].x = -2.0;
        zDists[dispatchThreadID.x].y = -1.0;
        //X E
        return;
        //X E
    }
    //Setup
    uint count=shapeEnds[dispatchThreadID.x+1];
    zDists[dispatchThreadID.x].x=0.0;
    zDists[dispatchThreadID.x].y=0.0;
    //Loop through points
    while (count != shapeEnds[dispatchThreadID.x]) {
        count-=1;
        if (isnan(points2d[shapes[count]].x)||isnan(points2d[shapes[count]].y)) {
            zDists[dispatchThreadID.x].x = -1.0;
            zDists[dispatchThreadID.x].y = -1.0;
            //X E
            return;
            //X E
        }
        zDists[dispatchThreadID.x].x+=points[2*unitSize+shapes[count]*unitSize+xyz[2]]-points[xyz[2]];
        zDists[dispatchThreadID.x].y+=sqrt((points[2*unitSize+shapes[count]*unitSize+xyz[0]]-points[xyz[0]])*(points[2*unitSize+shapes[count]*unitSize+xyz[0]]-points[xyz[0]])+
        (points[2*unitSize+shapes[count]*unitSize+xyz[1]]-points[xyz[1]])*(points[2*unitSize+shapes[count]*unitSize+xyz[1]]-points[xyz[1]]));
    }
    //divide to get average
    zDists[dispatchThreadID.x].x/=shapeEnds[dispatchThreadID.x+1]-shapeEnds[dispatchThreadID.x];
    if (zDists[dispatchThreadID.x].x < -0.0) {
        zDists[dispatchThreadID.x].x = -zDists[dispatchThreadID.x].x;
    }
    zDists[dispatchThreadID.x].y/=shapeEnds[dispatchThreadID.x+1]-shapeEnds[dispatchThreadID.x];
    //X E
}
//X E
