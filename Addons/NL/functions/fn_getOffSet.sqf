/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Object <OBJECT>
 *
 * Example:
 * [Object] call NURMI_NL_fnc_getOffSet;
 *
 * Discription:
 * <Placeholder>
 *
 */

params ["_object"];

private _size = boundingBoxReal _object;
private _height = abs (((_size select 1) select 2) - ((_size select 0) select 2));
private _pos = ASLToATL getPosASL _object;
private _realHeight = (_pos select 2) + _height;

if (_realHeight > 1.8) then {
	_offSet = _object worldToModel [_pos select 0, _pos select 1, 1.6];
} else {
	_offSet = _object worldToModel [_pos select 0, _pos select 1, _realHeight];
};

_offSet