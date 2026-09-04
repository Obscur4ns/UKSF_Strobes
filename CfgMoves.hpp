class CfgMovesBasic
{
    class ManActions
    {
        UKSF_Strobes_Operate = "UKSF_Strobes_Operate";
    };
    class Actions
    {
        class NoActions: ManActions
        {
            UKSF_Strobes_Operate[] = {"UKSF_Strobes_Operate","Gesture"};
        };
    };
};
class CfgGesturesMale
{
    skeletonName = "OFP2_ManSkeleton";
    class Default;
    class States
    {
        class UKSF_Strobes_Operate: Default
        {
            file = "\UKSF_Strobes\anim\Strobe.rtm";
            looped = 0;
            speed = 1;
            minPlayTime = 0.9;
            mask = "UKSF_Strobes_LeftArmMask";
            canPullTrigger = 1;
            forceAim = 1;
            disableWeapons = 0;
            disableWeaponsLong = 0;
            canReload = 0;
            enableBinocular = 1;
            enableMissile = 1;
            enableOptics = 1;
            headBobMode = 0;
            headBobStrength = 0;
            interpolationRestart = 0;
            interpolationSpeed = 6;
            preload = 1;
            ragdoll = 0;
            relSpeedMax = 1;
            relSpeedMin = 1;
            showHandGun = 0;
            showItemInHand = 0;
            showItemInRightHand = 0;
            showWeaponAim = 1;
            soundEnabled = 1;
            static = 0;
            terminal = 0;
            leftHandIKBeg = 0;
            leftHandIKCurve[] = {0};
            leftHandIKEnd = 0;
            rightHandIKBeg = 1;
            rightHandIKCurve[] = {1};
            rightHandIKEnd = 1;
            weaponLowered = 0;
            limitGunMovement = 0;
        };
    };
    class BlendAnims
    {
        UKSF_Strobes_LeftArmMask[] =
        {
            "weapon",0,
            "Pelvis",0,
            "Spine",0,
            "Spine1",0,
            "Spine2",0,
            "Spine3",0,
            "Camera",0,
            "launcher",0,
            "neck",1,
            "neck1",1,
            "head",1,
            "LeftShoulder",1,
            "LeftArm",1,
            "LeftArmRoll",1,
            "LeftForeArm",1,
            "LeftForeArmRoll",1,
            "LeftHand",1,
            "RightShoulder",0,
            "RightArm",0,
            "RightArmRoll",0,
            "RightForeArm",0,
            "RightForeArmRoll",0,
            "RightHand",0,
            "LeftUpLeg",0,
            "LeftUpLegRoll",0,
            "LeftLeg",0,
            "LeftLegRoll",0,
            "LeftFoot",0,
            "LeftToeBase",0,
            "RightUpLeg",0,
            "RightUpLegRoll",0,
            "RightLeg",0,
            "RightLegRoll",0,
            "RightFoot",0,
            "RightToeBase",0,
            "LeftHandIndex1",1,
            "LeftHandIndex2",1,
            "LeftHandIndex3",1,
            "LeftHandMiddle1",1,
            "LeftHandMiddle2",1,
            "LeftHandMiddle3",1,
            "LeftHandPinky1",1,
            "LeftHandPinky2",1,
            "LeftHandPinky3",1,
            "LeftHandRing",1,
            "LeftHandRing1",1,
            "LeftHandRing2",1,
            "LeftHandRing3",1,
            "LeftHandThumb",1,
            "LeftHandThumb1",1,
            "LeftHandThumb2",1,
            "LeftHandThumb3",1,
            "RightHandIndex1",0,
            "RightHandIndex2",0,
            "RightHandIndex3",0,
            "RightHandMiddle1",0,
            "RightHandMiddle2",0,
            "RightHandMiddle3",0,
            "RightHandPinky1",0,
            "RightHandPinky2",0,
            "RightHandPinky3",0,
            "RightHandThumb",0,
            "RightHandThumb1",0,
            "RightHandThumb2",0,
            "RightHandThumb3",0
        };
    };
};